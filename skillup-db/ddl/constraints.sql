ALTER TABLE usuario_competencia
  ADD CONSTRAINT fk_uc_usuario
      FOREIGN KEY (id_usuario)
      REFERENCES usuario (id_usuario);

ALTER TABLE usuario_competencia
  ADD CONSTRAINT fk_uc_competencia
      FOREIGN KEY (id_competencia)
      REFERENCES competencia (id_competencia);

ALTER TABLE curso_competencia
  ADD CONSTRAINT fk_cc_curso
      FOREIGN KEY (id_curso)
      REFERENCES curso (id_curso);

ALTER TABLE curso_competencia
  ADD CONSTRAINT fk_cc_competencia
      FOREIGN KEY (id_competencia)
      REFERENCES competencia (id_competencia);

ALTER TABLE matricula_curso
  ADD CONSTRAINT fk_mc_usuario
      FOREIGN KEY (id_usuario)
      REFERENCES usuario (id_usuario);

ALTER TABLE matricula_curso
  ADD CONSTRAINT fk_mc_curso
      FOREIGN KEY (id_curso)
      REFERENCES curso (id_curso);

ALTER TABLE vaga_competencia
  ADD CONSTRAINT fk_vc_vaga
      FOREIGN KEY (id_vaga)
      REFERENCES vaga (id_vaga);

ALTER TABLE vaga_competencia
  ADD CONSTRAINT fk_vc_competencia
      FOREIGN KEY (id_competencia)
      REFERENCES competencia (id_competencia);
